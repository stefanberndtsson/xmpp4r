#!/usr/bin/ruby

$:.unshift '../lib'

require 'test/unit'
require 'xmpp4r/jid'
include Jabber

class JIDTest < Test::Unit::TestCase
  def test_create1
    j = JID::new('a', 'b', 'c')
    assert_equal('a', j.node)
    assert_equal('b', j.domain)
    assert_equal('c', j.resource)
  end

  def test_create2
    j = JID::new('a', 'b', 'c')
    j2 = JID::new(j)
    assert_equal('a', j2.node)
    assert_equal('b', j2.domain)
    assert_equal('c', j2.resource)
  end

  def test_create3
    j = JID::new('a@b/c')
    assert_equal('a', j.node)
    assert_equal('b', j.domain)
    assert_equal('c', j.resource)
  end

  def test_create4
    j = JID::new('a@b')
    assert_equal('a', j.node)
    assert_equal('b', j.domain)
    assert_equal(nil, j.resource)
  end

  def test_create5
    j = JID::new
    assert_equal(nil, j.node)
    assert_equal(nil, j.domain)
    assert_equal(nil, j.resource)
  end

  def test_create6
    j = JID::new('dom')
    assert_equal(nil, j.node)
    assert_equal('dom', j.domain)
    assert_equal(nil, j.resource)
  end

  def test_tos
    assert_equal('',JID::new.to_s)
    assert_equal('domain.fr',JID::new('domain.fr').to_s)
    assert_equal('l@domain.fr',JID::new('l','domain.fr').to_s)
    assert_equal('l@domain.fr/res',JID::new('l','domain.fr','res').to_s)
    assert_equal('domain.fr/res',JID::new(nil,'domain.fr','res').to_s)
  end

  def test_equal
    assert_equal(JID::new('domain.fr'), JID::new('domain.fr'))
    assert_equal(JID::new('l@domain.fr'), JID::new('l@domain.fr'))
    assert_equal(JID::new('l@domain.fr/res'), JID::new('l@domain.fr/res'))
  end

  def test_hash
    h = {}
    j = JID::new('l@domain.fr/res')
    h[j] = 'a'
    assert_equal(h[j], h[JID::new('l@domain.fr/res')])
  end
end
